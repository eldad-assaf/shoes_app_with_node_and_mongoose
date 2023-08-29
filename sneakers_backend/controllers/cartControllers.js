const Product = require("../models/Product");
const Cart = require("../models/Cart");

module.exports = {
  addCart: async (req, res) => {
    console.log('addCart')
    const userId = req.user.id;
    console.log(userId)
    const { cartItem, quantity } = req.body;
    console.log(cartItem)
    console.log(quantity)


    try {

      const cart = await Cart.findOne({ userId });
     // console.log(cart);
      if (cart) {
        console.log("Cart products:", cart.products);
        const existingProduct = cart.products.find(
          (product) => product.cartItem.toString() === cartItem.toString()
        );
    
        console.log("Existing Product:", existingProduct);
   

        if (existingProduct) {
          console.log('existingProduct')
          existingProduct.quantity += 1;
        } else {
          cart.products.push({ cartItem, quantity: 1 });
        }
        await cart.save();
        res.status(200).json("Product added to the cart");
      } else {
        console.log('newProduct')

        const newCart = new Cart({
          userId,
          products: [{ cartItem, quantity: 1 }],
        });
        await newCart.save();
        res.status(200).json("Product added to the cart");
      }
    } catch (error) {
      console.log(error);
      res.status(500).json(error);
    }
  },

  getCart: async (req, res) => {
    const userId = req.user.id;

    try {
      const cart = await Cart.findOne({ userId }).populate('products.cartItem', '_id name imageUrl price category');
      console.log(cart);
      res.status(200).json(cart);
    } catch (error) {
      res.status(500).json({eldad : 'eldaddada'});
    }
  },
  deleteCartItem: async (req, res) => {
    const cartItemId = req.params.cartItem;

    try {
      const updatedCart = await Cart.findOneAndUpdate(
        { "products._id": cartItemId },
        { $pull: { products: { _id: cartItemId } } },
        { new: true }
      );

      if (!updatedCart) {
        res.status(404).json({ message: "Care item not found" });
      }
      res.status(200).json(updatedCart);
    } catch (error) {
      res.status(500).json(error);
    }
  },
};

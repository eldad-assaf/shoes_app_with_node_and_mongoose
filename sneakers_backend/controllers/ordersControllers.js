const Orders = require("../models/Orders");

module.exports = {
  getUserOrders: async (req, res) => {
    //from the middleware 'verifyToken' ?
    const UserId = req.user.id;

    const userOrders = await Orders.find({ userId }).populate({
      path: "productId",
      select: "-sizes-oldPrice-description-category",
    }).exec();
    res.status(200).json(userOrders);


    try {
    } catch (error) {
      res.status(500).json({ message: "Failed to get orders" });
    }
  },
};

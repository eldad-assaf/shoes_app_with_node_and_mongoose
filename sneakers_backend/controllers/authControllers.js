const User = require("../models/User");
const CryptoJS = require("crypto-js");
const jwt = require("jsonwebtoken");

//These are the functions that handle all the user auth scenarios

module.exports = {
  createUser: async (req, res) => {
    //'User' is a  - 'mongoose.Schema'
    const newUser = new User({
      username: req.body.username,
      email: req.body.email,

      password: CryptoJS.AES.encrypt(
        req.body.password,
        process.env.SECRET
      ).toString(),
      location: req.body.location,
    });

    try {
      await newUser.save();
      res.status(201).json({ message: "User Successfully Created" });
    } catch (error) {
      res.status(500).json({ message: error });
    }
  },

  loginUser: async (req, res) => {
    //first, find the user by his Email

    try {
      const user = await User.find({ email: req.body.email });

      !user && res.status(401).json("Could not find the user");

      const decryptedPassword = CryptoJS.AES.decrypt(
        user.password,
        process.env.SECRET
      );
      const thePassword = decryptedPassword.toString(CryptoJS.enc.Utf8);

      thePassword !== req.body.password &&
        res.status(401).json("Wrong Password");

      const userToken = jwt.sign(
        {
          id: user._id,
        },
        process.env.JWT_SEC,
        { expiresIn: "21d" }
      );

      const { password, __v, createdAt, ...others } = user._doc;

      res.status(200).json({ ...others, token: userToken });
    } catch (error) {
      res.status(200).json('Failed to login...check your credentials');

    }
  },
};

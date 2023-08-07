const User = require("../models/User");

module.exports = {
  getUser: async (req, res) => {
    try {
      const user = await User.findById(req.user.id);
      const { password, __v, createdAt, updatedAt, ...userData } = user._doc;
      res.status(200).json(userData);
    } catch (error) {
      res.status(500).json(error);
    }
  },
  deleteUser: async (req, res) => {
    try{
        const user = await User.findByIdAndDelete(req.user.id);
        res.status(200).json("User successfully deleted");


    }catch(error){
        res.status(500).json(error);

    }
    const user = await User.findByIdAndDelete(req.user.id);

  },
};

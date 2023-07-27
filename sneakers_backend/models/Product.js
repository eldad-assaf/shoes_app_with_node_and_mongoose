const mongoose = require("mongoose");

const ProductSchema = new mongoose.Schema(
  {
    name: { type: String, required: true },
    title: { type: String, required: true },
    category: { type: String, required: true }, // Corrected property name
    imageUrl: { type: [String], required: true },
    oldPrice: { type: String, required: true },
    sizes: {
      type: [
        {
          size: {
            type: String,
            required: true,
          },
          isSelected: {
            type: Boolean,
            required: false,
          },
        },
      ],
    },

    price: { type: String, required: true },
    description: { type: String, required: true },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Product", ProductSchema);

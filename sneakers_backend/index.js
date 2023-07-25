//same as app.js

const express = require("express");
const app = express();
const dotenv = require("dotenv");
const port = 3000;

dotenv.config();

app.listen(process.env.PORT || 3005, () =>
  console.log(`Example app listening on port ${process.env.PORT}!`)
);

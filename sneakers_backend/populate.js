require('dotenv').config()

const Product = require('./models/Product')

const mensShoesJson = require('../assets/json/men_shoes.json')
const womensShoesJson = require('../assets/json/women_shoes.json')
const kidsShoesJson = require('../assets/json/kids_shoes.json')



const mongoose = require('mongoose')

const connectDB = (url) => {
  return mongoose.connect(url, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
}

const start = async () => {
  try {
    console.log('connectDB');
    console.log(process.env.MONGO_URL);
    await connectDB(process.env.MONGO_URL)
    //** DELETES ALL THE CURRENT DATA FOR THE PRODUCT - OPTIONAL */
  //  await Product.deleteMany({category : "Kids' Running"})
    //CREATE A DOCUMET FOR EACH PRODUCT IN THE JSON FILE
    await Product.create(kidsShoesJson)
    console.log('Success!!!!')
    //**EXIT - STOPS THE RUN PROCESS OF THE FILE ( 0 IS SUCCESS , 1 IS FAILURE)  */
    process.exit(0)
  } catch (error) {
    console.log(error)
    process.exit(1)
  }
}

start()

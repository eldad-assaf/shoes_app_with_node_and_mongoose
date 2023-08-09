const router = require('express').Router()
const ordersControllers = require('../controllers/ordersControllers')
const {verifyToken} = require('../middleware/verifyToken')


router.get('/' , verifyToken, ordersControllers.getUserOrders)


module.exports = router
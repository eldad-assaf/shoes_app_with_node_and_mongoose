const router = require('express').Router()
const usersControllers = require('../controllers/usersControllers')
const {verifyToken} = require('../middleware/verifyToken')


router.get('/' , verifyToken, usersControllers.getUser)
router.delete('/' ,verifyToken ,usersControllers.deleteUser)


module.exports = router
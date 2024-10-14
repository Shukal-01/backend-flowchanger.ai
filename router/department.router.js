import {Router} from 'express'


import {addDepartment, updateDepartment,fetchDepartment, deleteDepartment,showDepartment} from '../controller/department.controller.js';

const router = Router()

router.post('/', addDepartment)
router.put('/:id', updateDepartment)
router.get('/', fetchDepartment)
router.delete('/:id', deleteDepartment)
router.get('/:id', showDepartment)

export default router
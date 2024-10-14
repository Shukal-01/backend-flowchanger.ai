import { Router} from "express"

const router = Router();

import department from './department.router.js';

router.use('/department', department);

export default router;

import express from 'express';
import router from './router/routes.js';

const app = express();

app.use(express.json());
const PORT = process.env.PORT || 8000;

app.use(express.json());
app.use(express.urlencoded({extended:false}));

app.use(router);

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});

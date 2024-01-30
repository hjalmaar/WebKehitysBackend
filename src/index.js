import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';

const hostname = '127.0.0.1';
const port = 3000;
const app = express();
app.use(express.json()); 

app.use(express.static('public'));

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
app.use('/sivusto', express.static(path.join(__dirname, '../public')));

const items = [
  { id: 1, name: 'Item 1' },
  { id: 2, name: 'Item 2' },
  { id: 3, name: 'Item kolme' },
  { id: 4, name: 'Item neljä' },
];

app.get('/items', (req, res) => {
  res.json(items);
});

app.get('/items/:id', (req, res) => {
  const requestedId = parseInt(req.params.id, 10);
  const item = items.find(item => item.id === requestedId);
  if (item) {
    res.json(item);
  } else {
    res.status(404).send('Item not found');
  }
});

app.post('/items', (req, res) => {
  const newItem = {
    id: items.length + 1,
    name: req.body.name
  };
  items.push(newItem);
  res.status(201).json(newItem);
});

app.get('/', (req, res) => {
  res.send('Welcome to my REST api!');
});

app.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});

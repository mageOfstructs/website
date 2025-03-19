import express from "express";

import { fileURLToPath } from "node:url";
import { dirname } from "node:path";

const app = express();
const port = 8080;

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

app.use(express.json());
app.use(express.static("client"));

app.get(
  "/test",
  (req, res) =>
    res.end("Hello from Express! (yes yes this will be changed to Rust later)"),
);

app.listen(port, () => {
  console.log(`listening on port ${port}`);
});

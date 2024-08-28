const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send('Hola Mundo! Soy Eduardo Pinto, estudiante de UNIR!')
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
from fpdf import FPDF

# Crear una clase PDF personalizada para mejor formato
class PDF(FPDF):
    def header(self):
        self.set_font("Arial", "B", 14)
        self.cell(0, 10, "Guía completa: Proyecto Express.js desde cero", ln=True, align="C")
        self.ln(5)

    def chapter_title(self, title):
        self.set_font("Arial", "B", 12)
        self.set_text_color(33, 37, 41)
        self.cell(0, 10, title, ln=True)
        self.ln(2)

    def chapter_body(self, body):
        self.set_font("Arial", "", 11)
        self.set_text_color(50, 50, 50)
        self.multi_cell(0, 8, body)
        self.ln()

# Crear el PDF
pdf = PDF()
pdf.add_page()
pdf.set_auto_page_break(auto=True, margin=15)

# Contenido explicativo
contenido = [
    ("¿Qué es Express.js?",
     "Express.js es un framework minimalista para crear servidores web con Node.js. "
     "Permite definir rutas, middlewares, controladores y manejar peticiones HTTP fácilmente."),

    ("Estructura típica de un proyecto Express",
     """src/
├── controllers/        → Lógica que responde a rutas (acciones)
├── services/           → Lógica reutilizable y de negocio
├── models/             → Estructura de datos (conexión con DB)
├── routes/             → Define rutas y asigna controladores
├── middleware/         → Funciones que interceptan peticiones
├── validators/         → Validan datos de entrada
├── utils/              → Funciones auxiliares
├── tests/              → Pruebas automatizadas
"""),

    ("¿Quién llama a quién?",
     """- El navegador o cliente hace una petición HTTP (GET, POST, etc).
- Esa petición pasa primero por los middleware definidos (como `auth.js` o `validate.js`).
- Luego llega a la ruta correspondiente en `routes/`.
- Esa ruta ejecuta una función definida en un controlador (`controllers/`).
- El controlador puede llamar a funciones del servicio (`services/`), que a su vez interactúan con la base de datos a través de los modelos (`models/`)."""),

    ("Ejemplo de flujo completo (POST /api/login)",
     """1. El cliente hace un POST a /api/login con email y contraseña.
2. El middleware `validate.js` valida los datos.
3. La ruta definida en `routes/auth.js` llama a `authController.login`.
4. `authController.login` llama a `authService.login`.
5. `authService` verifica el usuario y contraseña.
6. Se genera un token y se envía como respuesta al cliente."""),

    ("Ejemplo de código - Ruta y controlador",
     """// routes/auth.js
const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const validate = require('../middleware/validate');
router.post('/login', validate.login, authController.login);

// controllers/authController.js
exports.login = async (req, res) => {
  const { email, password } = req.body;
  const token = await authService.login(email, password);
  res.json({ token });
};"""),

    ("Middleware - ¿Qué hace y quién lo usa?",
     """Los middleware son funciones que se ejecutan antes de llegar al controlador.
Pueden autenticar, validar, transformar datos, etc.

Ejemplo:
- `auth.js`: verifica si el usuario tiene token JWT. Se usa en rutas protegidas.
- `validate.js`: valida que los datos del cuerpo de la petición sean correctos.
Ambos se colocan en las rutas. No los llama el controlador directamente, sino Express los ejecuta en orden."""),

    ("Servicios - ¿Qué hacen y quién los llama?",
     """Los servicios realizan la lógica de negocio, consultas a base de datos u operaciones complejas.
- Los llama el controlador.
- No tienen acceso directo a la petición (req, res), solo hacen cálculos y retornan datos.

Ejemplo:
`authService.js` contiene funciones como `login(email, password)`."""),

    ("Modelos - ¿Qué hacen y quién los llama?",
     """Los modelos definen cómo se ve un objeto en la base de datos.
- Usualmente se usan con Mongoose o Sequelize.
- Los llaman los servicios para leer/escribir datos."""),

    ("Validadores - ¿Quién los usa?",
     """Los validadores definen qué datos son válidos para cada endpoint.
- Los llama un middleware (como `validate.js`).
- Generalmente se usan librerías como Joi o express-validator."""),

    ("Conclusión",
     """Esta arquitectura ayuda a separar responsabilidades:
- Rutas definen qué se hace.
- Middleware preparan la petición.
- Controladores ejecutan acciones.
- Servicios contienen la lógica.
- Modelos manejan los datos.
Esto facilita mantener, escalar y testear tu proyecto Express.js.""")
]

# Agregar contenido al PDF
for titulo, texto in contenido:
    pdf.chapter_title(titulo)
    pdf.chapter_body(texto)

# Guardar PDF
pdf_path = "/mnt/data/guia_proyecto_express_desde_cero.pdf"
pdf.output(pdf_path)
pdf_path

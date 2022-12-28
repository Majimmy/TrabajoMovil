# TrabajoMovil: Biblioteca mini usando Flutter
#### (Trabajo final en direcctorio "app_v1_android")<br>(nota: no se pudo subir apk generado ya que el archivo supera el limite de 25MB)<br>(para el profesor: link para ver apk generado: <https://drive.google.com/drive/u/1/folders/1fxEfxhKetUSJ-S1y9BvRACoE8zBjJILE>)
<br>
Esta aplicacion montada con flutter, solicita el ingreso de un usuario, solicita datos para armar una estructura,
<br>y los enviar juntos a una base de datos mongodb a travez de un backend montado con nodejs.

#### Se requiere visual studio code, docker, postman, flutter y android studio instalados.<br> Se recomienda tener tambien mongodb compass

## montar mongo data base
- instalar docker y hacerlo funcionar
- ir a terminal en la carpeta backend y escribir:<br>
   docker run --name mongodb -d -p 27017:27017 mongo
 (docker debe estar encendido)
- iniciar la instancia mongodb
## visualizar los datos del container mongodb:
- instalar mongo compass
- utilizar la ruta de la base de datos default:<br>
  (mongodb://localhost:27017)
- ver la base de datos llamada "test"
## montar frontend:
- crear proyecto de flutter. Ejemplo: <br>
flutter create proyecto<br>
cd proyecto<br>
flutter run
- añadir los archivos y carpetas que se encuentran en el directorio "frontend"
- correr el commando: flutter pub get
- esto hará conseguir las librerias necesarias para el proyecto
## montar backend:
- crear carpeta para proyecto de backend
- añadir los archivos y carpetas presentes en el directorio "backend"
- correr el comando: "npm install"  para instalar las dependencias que incluye el archivo "package.json"
- crear un archivo .env y configurar como le convenga a su proyecto.<br>
se puede encontrar un ejemplo de configuración en el archivo "ejemplo.env.txt"
- para utilizar la aplicación, necesitará un usuario. puede crear un usuario utilizando la herramienta postman,<br>
como lo muestra la imagen de ejemplo llamada "ejemplo_ingresar_usuario_postman.png"
## compilar/hacer apk:
- una vez todo listo, se puede hacer correr el siguiente comando en terminal: "flutter run"<br>
este le dará opciones de trabajo. elija la opcion que ofrece android.
- si su emulador de android no aparece en la lista, primero utilice en terminal: "flutter emulators"<br>
este comando desplegará los emuladores disponibles. despues, elija su emulador y lo ejecuta<br>
de la forma: "flutter emulators --launch (nombre_emulador_disponible)"
- una vez abierto, ya puede ejecutar: "flutter run" de manera normal.

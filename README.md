# FormulAPP1

FormulAPP1 es una aplicación iOS desarrollada con Swift y SwiftUI que permite consultar información detallada sobre la Fórmula 1: clasificaciones de pilotos y constructores, circuitos, eventos y más. Está diseñada para los aficionados de la F1 que buscan una herramienta completa, visual y personalizable.

## 📱 Características

- Consulta de clasificaciones de pilotos y escuderías con datos actualizados.
- Fichas detalladas de cada piloto, escudería y circuito.
- Selección de piloto y constructor favoritos.
- Widgets para ver información desde la pantalla principal del dispositivo.
- Personalización de tema (claro/oscuro) e idioma (español, euskera, inglés).
- Sistema de navegación por pestañas y recarga de datos con gesto pull-to-refresh.

## 🧠 Arquitectura

La aplicación sigue una arquitectura **MVVM + Clean**, separando claramente las capas de presentación, dominio y datos:

```
FormulAPP1/
├── App/
├── Common/
├── Data/
│   ├── datamodels/
│   ├── mappers/
│   ├── network/
│   └── repositories/
├── Domain/
│   └── domainmodels/
├── Presentation/
│   ├── viewmodels/
│   └── views/
└── Resources/
```

Además, el proyecto contiene una extensión para widgets (`FormulAPP1-widgets`) con su propio repositorio y ViewModel.

## 🛠️ Tecnologías utilizadas

- **Swift** y **SwiftUI**: Desarrollo de interfaces modernas.
- **Combine**: Programación reactiva.
- **Core Data**: Persistencia local.
- **Alamofire**: Cliente HTTP para llamadas a API.
- **WidgetKit**: Creación de widgets.
- **App Groups**: Compartir datos entre la app y la extensión de widgets.
- **UserDefaults**: Almacenamiento de preferencias.

## 🧩 Funcionalidades destacadas

- **Widgets**: Visualiza tu piloto o escudería favoritos sin abrir la app.
- **Multilenguaje**: Soporte completo para tres idiomas (ES, EN, EU).
- **Notificaciones**: Implementación de recordatorios personalizados.
- **Dark mode**: Soporte de temas claros y oscuros.

## 🧪 Áreas de mejora

- Vincular los resultados de carrera con las clasificaciones (relación eventos-clasificaciones).
- Mejorar la implementación de Clean Architecture añadiendo *Use Cases*.
- Resolver conflictos de copyright para poder publicar en la App Store.

## 🚀 Instalación

1. Clona el repositorio:
   ```bash
   git clone https://github.com/anderpri-dev/FormulAPP1-iOS.git
   ```
2. Abre el proyecto en Xcode:
   ```bash
   open FormulAPP1.xcodeproj
   ```
3. Asegúrate de tener un dispositivo o simulador con iOS 17+.
4. Compila y ejecuta.

> Requiere conexión a internet para actualizar datos desde la API.

## 👤 Desarrollador

**Ander Prieto**

Máster en Informática Móvil – Universidad Pontificia de Salamanca

[LinkedIn](https://linkedin.com/in/ander-prieto) • [GitHub](https://github.com/anderpri-dev)

---

## 📄 Licencia

Este proyecto es de carácter académico. Algunos recursos visuales o de datos pueden estar sujetos a derechos de autor de terceros (ej. Formula 1).  

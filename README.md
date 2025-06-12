# base_template

A new Flutter project.

## Flujo completo desde la UI hasta el dominio (basado en los principios y recomendaciones del libro "System Design Blueprint" aplicado a Flutter + Clean Architecture, en conjunto con buenas prácticas modernas.)

                [Usuario] → LoginScreen
                           ↓
                  [Controller (GetX)]
                           ↓
                    LoginUseCase (Dominio)
                           ↓
       AuthRepositoryImpl (Infraestructura → Dominio)
                           ↓
            AuthApiDataSource (Infraestructura → Externo)
                           ↓
      LoginRequestDTO (construido desde LoginEntity)
                           ↓
                 → POST a API (/auth/login)
                           ↓
      JSON recibido de la API → LoginResponseModel.fromJson()
                           ↓
     LoginApiMapper: LoginResponseModel → AuthEntity
                           ↓
             LoginUseCase devuelve AuthEntity
                           ↓
           LoginController guarda token, navega, etc.

“A helper or utility should encapsulate technical responsibilities only, not domain-specific concerns. Avoid introducing business logic into infrastructural helpers.” : Función técnica (leer/escribir datos)

¿Por qué usar `/lib/services/`?
🔁 Tenga lógica específica del negocio de sesión
🧩 Use helpers técnicos (SecureStorageHelper)
🎯 No sea solo una función técnica ni tampoco del dominio puro

| Criterio                      | ¿Por qué usar `/services/`?                          |
| ----------------------------- | ---------------------------------------------------- |
| **Lógica de sesión**          | Guarda token, clave, limpia sesión                   |
| **Usa almacenamiento**        | Pero no es un helper genérico                        |
| **Es transversal al negocio** | Puede ser usada por login, logout, auth interceptor  |
| **Reutilizable por feature**  | Puede usarse desde múltiples módulos de presentación |

| Ruta            | Motivo                                      |
| --------------- | ------------------------------------------- |
| `core/utils/`   | 🔴 Mezclarías lógica de negocio con helpers |
| `domain/`       | 🔴 No es lógica del dominio puro            |
| `data/`         | 🔴 No es un datasource ni repositorio       |
| `presentation/` | 🔴 No es lógica de UI ni controlador        |

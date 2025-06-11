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

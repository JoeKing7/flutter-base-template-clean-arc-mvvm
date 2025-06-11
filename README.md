# base_template

A new Flutter project.

## Flujo completo desde la UI hasta el dominio (según el libro)

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

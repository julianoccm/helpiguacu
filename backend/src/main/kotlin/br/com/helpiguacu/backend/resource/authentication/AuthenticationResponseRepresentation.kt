package br.com.helpiguacu.backend.resource.authentication

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import io.swagger.v3.oas.annotations.media.Schema

@JsonIgnoreProperties(ignoreUnknown = true)
@Schema(description = "Authentication response representation")
data class AuthenticationResponseRepresentation (

    @field:Schema(description = "Bearer Token")
    val token: String,

    @field:Schema(description = "Logged user")
    val user: UserRepresentation
)
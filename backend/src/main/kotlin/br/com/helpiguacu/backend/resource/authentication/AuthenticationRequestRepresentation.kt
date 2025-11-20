package br.com.helpiguacu.backend.resource.authentication

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import io.swagger.v3.oas.annotations.media.Schema

@JsonIgnoreProperties(ignoreUnknown = true)
class AuthenticationRequestRepresentation (

    @param:Schema(description = "User username")
    val username: String,

    @param:Schema(description = "User password")
    val password: String
)
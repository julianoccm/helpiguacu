package br.com.helpiguacu.backend.resource.authentication

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import io.swagger.v3.oas.annotations.media.Schema

@JsonIgnoreProperties(ignoreUnknown = true)
@Schema(description = "Authentication response representation")
data class UserRepresentation(
    @field:Schema(description = "User identifier")
    val id: Long,

    @field:Schema(description = "User name")
    val name: String,

    @field:Schema(description = "User CPF")
    val cpf: String,

    @field:Schema(description = "User email")
    val email: String,

    @field:Schema(description = "User password")
    val password: String,

    @field:Schema(description = "User postal code (CEP)")
    val cep: String,

    @field:Schema(description = "User address number")
    val addresNumber: String,

    @field:Schema(description = "User address complement")
    val addresComplement: String
)
package br.com.helpiguacu.backend.resource.handler

data class ErrorResponse(
    val timestamp: String,
    val status: Int,
    val error: String,
    val type: String,
    val message: String?,
    val path: String
)
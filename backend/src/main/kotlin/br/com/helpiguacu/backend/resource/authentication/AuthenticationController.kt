package br.com.helpiguacu.backend.resource.authentication

import br.com.helpiguacu.backend.domain.exception.AuthenticationException
import br.com.helpiguacu.backend.domain.model.authentication.AuthenticationFacade
import io.swagger.v3.oas.annotations.Operation
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/auth/v1")
@Tag(name = "Authentication Controller", description = "Authentication APIs")
class AuthenticationController(
    private val authenticationFacade: AuthenticationFacade
) {

    @PostMapping("/login")
    @Operation(summary = "Users login", description = "Authenticate user and return a token")
    fun login(@RequestBody request: AuthenticationRequestRepresentation): ResponseEntity<AuthenticationResponseRepresentation> {
        try {
            val authenticationResponseRepresentation = authenticationFacade.login(request.username, request.password)
            return ResponseEntity.ok(authenticationResponseRepresentation)
        } catch (e: AuthenticationException) {
            return ResponseEntity.badRequest().build()
        }
    }
}
package br.com.helpiguacu.backend.resource.handler

import br.com.helpiguacu.backend.domain.exception.NotFoundException
import io.swagger.v3.oas.annotations.Hidden
import jakarta.servlet.http.HttpServletRequest
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.RestControllerAdvice
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

@Hidden
@RestControllerAdvice
class GlobalExceptionHandler : ResponseEntityExceptionHandler() {

    @ExceptionHandler(NotFoundException::class)
    fun handleAllNotFound(
        ex: NotFoundException,
        request: HttpServletRequest
    ): ResponseEntity<ErrorResponse> {
        val status = HttpStatus.NOT_FOUND

        val errorResponse = ErrorResponse(
            timestamp = LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME),
            status = status.value(),
            error = status.reasonPhrase,
            message = ex.message,
            type = ex.javaClass.simpleName,
            path = request.requestURI
        )

        return ResponseEntity(errorResponse, status)
    }
}
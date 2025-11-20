package br.com.helpiguacu.backend

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder

@SpringBootApplication
class BackendApplication

fun main(args: Array<String>) {
    print(BCryptPasswordEncoder().encode("senha"))
	runApplication<BackendApplication>(*args)
}

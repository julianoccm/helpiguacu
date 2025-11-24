package br.com.helpiguacu.backend.resource.donation

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import io.swagger.v3.oas.annotations.media.Schema

@JsonIgnoreProperties(ignoreUnknown = true)
@Schema(description = "Authentication response representation")
data class DonationItemRepresentation (
    @field:Schema(description = "Donaation item name")
    val name: String,

    @field:Schema(description = "Donation item quantity")
    val quantity: Int,

    @field:Schema(description = "Donation item observation")
    val observation: String? = null
)
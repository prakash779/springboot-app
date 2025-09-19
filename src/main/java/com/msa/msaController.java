package com.msa;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1")
public class msaController {

	@GetMapping("/hello")
	public ResponseEntity<String> helloApi(){
		return ResponseEntity.ok("Welcome to MSA");
	}
}

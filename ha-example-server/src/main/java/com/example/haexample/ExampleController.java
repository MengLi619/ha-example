package com.example.haexample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author Meng Li
 */
@RestController
public class ExampleController {

    private final ExampleRepository exampleRepository;

    @Autowired
    public ExampleController(ExampleRepository exampleRepository) {
        this.exampleRepository = exampleRepository;
    }

    @GetMapping("/examples")
    @Cacheable(value = "examples")
    public Page<Example> getAllPersons(Pageable pageable) {
        return exampleRepository.findAll(pageable);
    }
}
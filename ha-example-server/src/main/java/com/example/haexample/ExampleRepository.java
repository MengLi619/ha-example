package com.example.haexample;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @author Meng Li
 */
public interface ExampleRepository extends JpaRepository<Example, Long> {
}
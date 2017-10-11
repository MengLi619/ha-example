package com.example.haexample;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.cache.CacheManagerCustomizer;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.data.redis.cache.RedisCacheManager;

import java.util.HashMap;
import java.util.Map;

@SpringBootApplication
@EnableCaching
public class HaExampleServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(HaExampleServerApplication.class, args);
    }

    @Bean
    public CacheManagerCustomizer<RedisCacheManager> cacheManagerCustomizer() {

        return cacheManager -> {

            Map<String, Long> expires = new HashMap<>();
            expires.put("examples", 60L); // 60s

            cacheManager.setExpires(expires);
        };
    }
}
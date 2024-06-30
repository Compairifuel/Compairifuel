package org.compairifuel.compairifuelapi.utils;

import io.github.cdimascio.dotenv.Dotenv;
import jakarta.annotation.PostConstruct;
import jakarta.enterprise.inject.Default;

@Default
public class EnvConfigImpl implements IEnvConfig {
    private Dotenv dotenv;

    @PostConstruct
    public void init() {
            dotenv = Dotenv.configure()
                    .filename(".env")
                    .load();
    }

    public String getEnv(String key) {
        return dotenv.get(key);
    }
}
plugins {
  id("java")
  id("org.springframework.boot") version "3.2.3"
  id("io.spring.dependency-management") version "1.1.4"
}

sourceSets {
  main {
    java.setSrcDirs(setOf("."))
  }
}

java {
  toolchain {
    languageVersion.set(JavaLanguageVersion.of(17))
  }
  sourceCompatibility = JavaVersion.VERSION_17
  targetCompatibility = JavaVersion.VERSION_17
}

tasks.named<JavaCompile>("compileJava") {
  dependsOn(tasks.named("processResources"))
}

springBoot {
  mainClass.set("otel.DiceApplication")
}

repositories {
  mavenCentral()
}

dependencies {
  implementation("org.springframework.boot:spring-boot-starter-web")
}

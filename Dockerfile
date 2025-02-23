FROM maven:3.9.5-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .

COPY src/ ./src

RUN mvn package  

FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

ARG VERSION

COPY --from=build /app/target/my-app-${VERSION}.jar ./

CMD ["java", "-jar", "my-app-${VERSION}.jar"]


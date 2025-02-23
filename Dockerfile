FROM maven:3.9.2-eclipse-temurin-17-focal AS build

WORKDIR /app

COPY pom.xml .

COPY src/ ./src

RUN mvn clean  package --file pom.xml

FROM openjdk:17.0.2-slim-buster AS run 

WORKDIR /app

ARG VERSION

COPY --from=build /app/target/my-app-${VERSION}.jar ./

CMD ["java", "-jar", "my-app-${VERSION}.jar"]


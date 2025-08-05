# Etapa de construcción
FROM gradle:7.6.1-jdk17 AS builder

WORKDIR /asiscar-server
COPY . .

# Compilar la aplicación (genera archivos en /asiscar-server/target)
RUN ./gradlew assemble

# Etapa de ejecución
FROM openjdk:17-jdk-slim

WORKDIR /asiscar-server

# Copiar TODO el contenido de target desde la etapa de construcción
COPY --from=builder /asiscar-server/target/ .

# Puerto principal del servidor
EXPOSE 8082

# Comando de ejecución (asumiendo que tracker-server.jar está en target/)
CMD ["java", "-jar", "tracker-server.jar", "conf/traccar.xml"]
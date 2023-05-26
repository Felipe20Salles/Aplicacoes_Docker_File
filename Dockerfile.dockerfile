FROM alpine/git AS clone
WORKDIR /usr
RUN git clone <https://github.com/Felipe20Salles/Aplicacoes_Docker_File.git> .



FROM maven AS builder
WORKDIR /usr
COPY --from=clone /app/pom.xml .
RUN mvn -B dependency:go-offline
COPY . .
RUN mvn package

FROM maven
WORKDIR /usr
COPY --from=builder /app/src/main/java/iotd/Application.java .
EXPOSE 90
CMD ["java", "-jar", "app.jar"]



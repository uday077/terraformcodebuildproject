# 1. Base Image (Java 17 - Lightweight Alpine version)
FROM eclipse-temurin:17-jre-alpine

# 2. Working Directory set karna
WORKDIR /app

# 3. Batao ki App port 8080 par chalega (Best Practice)
EXPOSE 8080

# 4. Maven se bani hui JAR file ko container me copy karna
# Note: 'mvn package' command 'target' folder me jar banata hai
COPY target/*.jar app.jar

# 5. Container start hone par App chalana
ENTRYPOINT ["java", "-jar", "app.jar"]

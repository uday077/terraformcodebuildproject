# 1. Base Image (Java 17)
FROM eclipse-temurin:17-jre-alpine

# 2. Working Directory set karna
WORKDIR /app

# 3. Maven se bani hui JAR file ko container me copy karna
# Make sure aapka JAR file ka naam match kare (pom.xml se)
COPY target/*.jar app.jar

# 4. Container start hone par ye command chalegi
ENTRYPOINT ["java", "-jar", "app.jar"]

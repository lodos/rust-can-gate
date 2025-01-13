# Регистрация QEMU для эмуляции
FROM multiarch/qemu-user-static as qemu-setup
RUN qemu-user-static --reset

# Используем официальный образ для Rust
FROM rust:1.71 as builder

# Устанавливаем необходимые пакеты, включая pkg-config, libudev-dev, libssl-dev
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libudev-dev \
    pkg-config \
    qemu-user-static \
    && rm -rf /var/lib/apt/lists/*

# Создаем и переходим в рабочую директорию
WORKDIR /usr/src/app

# Копируем только Cargo.toml и Cargo.lock для кэширования зависимостей
COPY cangate-source/Cargo.toml cangate-source/Cargo.lock ./

# Копируем исходники проекта
COPY cangate-source/src/ ./src

# Устанавливаем зависимости и собираем приложение
RUN cargo build --release

# Используем более легкий образ для выполнения
FROM debian:bullseye-slim

# Устанавливаем необходимые зависимости для работы приложения
RUN apt-get update && apt-get install -y \
    libssl-dev \
    qemu-user-static \
    && rm -rf /var/lib/apt/lists/*

# Копируем скомпилированный бинарник из контейнера builder
COPY --from=builder /usr/src/app/target/release/cangate-source /usr/local/bin/cangate-source

# Копируем статические бинарные файлы для QEMU (если нужно эмулировать другую архитектуру)
COPY --from=builder /usr/local/bin/qemu-* /usr/bin/

# Делаем бинарник исполняемым
RUN chmod +x /usr/local/bin/cangate-source

# Открываем порт для приложения
EXPOSE 4444

# Запуск приложения
CMD ["cangate-source"]
// sniffer.rs

use std::time::Duration;
use tokio::time::sleep;

pub async fn start_sniffer() {
    println!("🚨 Сниффер запускается...");
    // Симуляция работы сниффера
    sleep(Duration::from_secs(5)).await;
    println!("🔍 Сниффинг завершён, обмен сообщениями был перехвачен.");
}
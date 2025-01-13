use std::process::Command;

// fn main() {
//     // Указываем путь к заголовочным файлам и библиотекам
//     println!("cargo:rerun-if-changed=build.rs");
//
//     // Путь к libpcan, если он установлен через Homebrew
//     let pcan_lib_path = "/usr/local/lib";
//
//     // Указываем путь к библиотеке
//     println!("cargo:libdir={}", pcan_lib_path);
//     println!("cargo:include={}/pcan", pcan_lib_path);
//
//     // Если нужно компилировать C-библиотеку
//     let status = Command::new("gcc")
//         .arg("-c")
//         .arg("src/pcan.c") // Путь к исходнику C
//         .arg("-o")
//         .arg("target/debug/pcan.o")
//         .status()
//         .expect("Не удалось скомпилировать pcan.c");
//
//     if !status.success() {
//         panic!("Ошибка при компиляции библиотеки pcan.");
//     }
// }
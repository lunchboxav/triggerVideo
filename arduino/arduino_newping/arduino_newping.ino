#include <NewPing.h>

#define TRIGGER_PIN  12  // pin trigger
#define ECHO_PIN     11  // pin echo
#define MAX_DISTANCE 500 // jarak maksimum yang bisa dilacak. jarak maksimum dari sensor adalah 400-500cm

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); // NewPing setup of pins and maximum distance.

void setup() {
  Serial.begin(9600); // memulai serial dengan laju transmisi 115200 bps
}

void loop() {
  delay(250);                      // menunggu 50ms sebelum memulai ping baru
  unsigned int uS = sonar.ping(); // mengirimkan ping, mendapat respon dalam sekian mikrosekon (uS)
  //Serial.print("Ping: ");
  //Serial.write(uS / US_ROUNDTRIP_CM); // mengubah dari waktu mengirim dan menerima ping, menjadi jarak dalam cm
  //Serial.println(uS / US_ROUNDTRIP_CM); 
  //Serial.println("cm");

  
  if (uS/US_ROUNDTRIP_CM < 200) {
    Serial.write(1);
  } else {
    Serial.write(0);
  }
  
}

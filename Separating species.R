library(tuneR)
library(tdsc)
library(seewave)

wave <- readWave("Gryllotalpa_vineae.wav")
ws1 <- cutw(wave, from=3, to=4, output="Wave")
td1 <- tdsc(ws1, max_D = 14)


wave <- readWave("Gryllotalpa_gryllotalpa.wav")
ws2 <- cutw(wave, from=3, to=4, output="Wave")
td2 <- tdsc(ws2, max_D = 14)

par(mfrow=c(2,2))
tdsc.plot(td1, main="Gryllotalpa vineae")
tdsc.plot(td2, main="Gryllotalpa gryllotalpa")
oscillo(ws1, labels=F)
oscillo(ws2, labels=F)

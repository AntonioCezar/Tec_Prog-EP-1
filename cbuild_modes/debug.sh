#!/bin/bash

# aqui jaz o script para ativar/desativar o modo debug.

# rafael aqui vc vai detectar se $1 = T, true, True... etc ou as variantes de false e ver se pode ativar e desativar a variavel $debug_mode. (ela é uma variável global logo basta colocar $debug_mode=true se quiser ligá-la e =false caso contário)
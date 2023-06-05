.data      
num_mayor:       .space  4     #Dir 0
nun_menor:       .space  4     #Dir  4 
cantmay:         .space  4     #dir  8
cantmen:         .space  4     #dir  12
long:            .word   25    #dir  16
const:           .word   1,4   #Dir inicio 20 
vect:            .word   25,50,23,22,21,1,67,4,10,67,9,20,33,20,1,1,2,34,67,20, 
                         5,9,67,1,20
retorno:         .space  4     #di3 130                   
#__________________________________________________________________________________________________________________
.text  
Main:        
              lw  $s0, 28($zero)       #Se direcciona apuntador al vector
              lw  $a1, 16($zero)       #Se obtiene el tamaño del arreglo
              jal mayor
              sw  $v0, 0($zero)        #Se guarda el mayor en memoria
              jal menor
              add $t0, $v0,$zero       #Para contar mayores 
              jal veces_rep
              sw  $v0, 8($zero)         #Se salva la cantidad de mayores en memoria
              add $t0, $s2, $zero       #Para contar los menores
              jal veces_rep
              sw  $v0, 12($zero)       #Se salva la cantidad de menores en memoria
            
END:          j END
#_____________________________________________________________________________________________________
mayor:        sw   $ra, 130($zero)
              lw   $t7, 20($zero)        #Se carga la constante 1
              lw   $t8, 24($zero)        #Se carga la constante 4
              add  $a0, $s0, $zero       #Se direcciona arreglo
              add  $t6, $zero, $t7       #Tamaño vector
              add  $t0, $zero, $zero      #mayor
              add  $t4, $zero, $zero       #menor
              add  $t1, $zero, $zero       #Cantidad caracteres leidos
loop3:        beq  $t1, $a1, exit_loop3
              lw   $t2, ($a0)
              slt  $t3 , $t2, $t0          #$t3 = 1 si $t0 < $ 2
              bne  $t3, $t6, save_mayor
              add  $a0, $a0, $t8
              add  $t1, $t1, $t7
              add  $t4, $t2, $zero         #Se salva el valor menor
              sw   $t4, 4($zero)
              j    loop3
save_mayor:   add  $t0, $t2, $zero        #Se salva el valor mayor        
              add  $a0, $a0, $t8
              add  $t1, $t1, $t7
              j    loop3
exit_loop3:   add  $v0, $t0, $zero         #Retorna el mayor
              add  $v1, $t4, $zero         #Retorna mayor
              lw   $ra, 130($zero)
              jr   $ra
#_____________________________________________________________________________________________________________________
veces_rep:   sw   $ra, 130($zero)
             lw   $t4, 20($zero)       # Se carga constante 1
             lw   $t5, 24($zero)        #Se carga constante 2
             add  $a0, $s0, $zero       #Se apunta a vector de enteros
             add  $t3, $zero, $zero     #Cantidad Repetidos
             add  $t1, $zero, $zero     #Caracteres leidos 
             lw   $t0, ($zero)          #Se lee numero
loop1:       beq  $t1,  $a1, exit_loop1  #Se verifica si se leyeron todos los valores del arrglo
             lw   $t2, ($a0)
             bne  $t0, $t2, no_count     #$s1 contiene el valor a contabilizar
             add  $t3, $t3, $t4          #Se actualiza contador de repetidos  
no_count:    add  $t1, $t1, $t4          #Se actualiza contador de caracteres leidos  
             add  $a0, $a0, $t5
             j loop1
exit_loop1:  add $v0, $t3, $zero
             lw   $ra, 130($zero)
             jr $ra     

#_______________________________________________________________________________________________________________________
menor:        sw   $ra, 130($zero)
              lw   $t7, 20($zero)        #Se carga la constante 1
              lw   $t8, 24($zero)        #Se carga la constante 4
              add  $a0, $s0, $zero       #Se direcciona arreglo
              add  $t6, $zero, $t7        #Es constante 1
              add  $t0, $zero, $zero       #mayor
              add  $t4, $zero, $zero       #menor
              add  $t1, $zero, $zero       #Cantidad caracteres leidos
              lw   $t0, ($a0)
              sw   $t0,4($zero)
loop4:        beq  $t1,  $a1, exit_loop4
              lw   $t2, ($a0)
              slt  $t3 , $t2, $t0          #$t3 = 1 si $t0 < $ 2
              bne  $t3, $t6, no_save
              add  $a0, $a0, $t8
              add  $t1, $t1, $t7
              add  $t0, $t2, $zero         #actualizo menor
              sw   $t1,4($zero)
              j    loop4
no_save:     
              add  $a0, $a0, $t8
              add  $t1, $t1, $t7
              j    loop4
exit_loop4: 
              lw   $ra, 130($zero)
              jr   $ra
              

/***********************
* VECTOR FUNCTIONS
***********************/

/***********************
* Add each part of the addend to the augend
***********************/
function vadd(augend, addend) =
    [ augend[0] + addend[0],
      augend[1] + addend[1],
      augend[2] + addend[2] ];

/***********************
* Subtract each part of the subtrahend from the minuend
***********************/
function vsub(minuend, subtrahend) =
    [ minuend[0] - subtrahend[0],
      minuend[1] - subtrahend[1],
      minuend[2] - subtrahend[2] ];

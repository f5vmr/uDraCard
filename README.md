# uDraCard
Software to Programm SA/DRA818 on uDraCard

![alt tag](https://i2.wp.com/blog.f8asb.com/wp-content/uploads/2020/11/udracardetusvxcard.png?w=500)

For more information on the uDracard go to : <http://blog.f8asb.com/usvxcard/>

## INSTALLATION Of the Program

This document require that you install the git package in the operating system.

<https://git-scm.com/book/fr/v2/Démarrage-rapide-Installation-de-Git>

```
Install as follows

git clone https://github.com/F5VMR/uDraCard.git
```
## CONFIGURATION OF THE SWITCHES ON THE uDraCard
It is necessary to place the switches 2 and 3 to ON.

## Start the program

```
sudo bash uDraCard/uDraCard_config.sh
```

## THE MENU

The menu is in two parts:

The first take the parameters to program the SA818 after answering the questions.

The second transfers the parameters to the SA818 by the series connection.


IMPORTANT: To move about the menu, use the arrow keys, and the space bar to select the menu item, and the tab key to go to the item to select or to cancel

## PROCEDURE
1- Power down the raspberry
```
sudo halt
```
2- Turn the switches 2 and 3 to ON

3- Power up the raspberry

4- Connect by SSH to the Raspberry via putty or another console.

5 -bash /opt/uDraCard/uDraCard_config.sh

6- choose the menu 1 and answer the questions to add each parameter

7- choose the menu 2 to program the SA818

8- Power down the raspberry ( see stage 1)

9- Turn the switches 2 and 3 to OFF

10- Power up the Raspberry


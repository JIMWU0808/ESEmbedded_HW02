HW02
===
This is the hw02 sample. Please follow the steps below.

# Build the Sample Program

1. Fork this repo to your own github account.

2. Clone the repo that you just forked.

3. Under the hw02 dir, use:

	* `make` to build.

	* `make clean` to clean the ouput files.

4. Extract `gnu-mcu-eclipse-qemu.zip` into hw02 dir. Under the path of hw02, start emulation with `make qemu`.

	See [Lecture 02 ─ Emulation with QEMU] for more details.

5. The sample is designed to help you to distinguish the main difference between the `b` and the `bl` instructions.  

	See [ESEmbedded_HW02_Example] for knowing how to do the observation and how to use markdown for taking notes.

# Build Your Own Program

1. Edit main.s.

2. Make and run like the steps above.

# HW02 Requirements

1. Please modify main.s to observe the `push` and the `pop` instructions:  

	Does the order of the registers in the `push` and the `pop` instructions affect the excution results?  

	For example, will `push {r0, r1, r2}` and `push {r2, r0, r1}` act in the same way?  

	Which register will be pushed into the stack first?

2. You have to state how you designed the observation (code), and how you performed it.  

	Just like how [ESEmbedded_HW02_Example] did.

3. If there are any official data that define the rules, you can also use them as references.

4. Push your repo to your github. (Use .gitignore to exclude the output files like object files or executable files and the qemu bin folder)

[Lecture 02 ─ Emulation with QEMU]: http://www.nc.es.ncku.edu.tw/course/embedded/02/#Emulation-with-QEMU
[ESEmbedded_HW02_Example]: https://github.com/vwxyzjimmy/ESEmbedded_HW02_Example

--------------------

- [x] **If you volunteer to give the presentation next week, check this.**

--------------------

#1.實驗題目
撰寫簡易組語觀察 pop & push 兩指令之差異。
#2.實驗步驟
1.先將資料夾 gnu-mcu-eclipse-qemu 完整複製到 ESEmbedded_HW02 資料夾中

2.根據 [ARM infomation center] 敘述的 pop, push 用法
*  POP     {r0,r10,pc} ;
*  PUSH    {r0,r4-r7} ;


3.設計測試程式 main.s ，從 _start 開始後依序執行 pop 以及 push 並且觀察其指令差異， 目標比較程式後面的pop和push執行時的變化。

main.s:
```_start:
	mov r0, sp
        mov r1, #3
        mov r2, #2
        mov r3, #1

        push {r1,r2,r3}
        pop {r1,r2,r3}

        push {r3}
        push {r1}
        push {r2}
        pop {r3}
        pop {r1}
        pop {r2}

```
4.將 main.s 編譯並以 qemu 模擬， `$ make clean`, `$ make`, `$ make qemu` 開啟另一 Terminal 連線 `$ arm-none-eabi-gdb` ，再輸入 `target remote localhost:1234` 連接，輸入兩次的 `ctrl + x` 再輸入 `2`, 開啟 Register 以及指令，並且輸入 `si` 單步執行觀察。 當執行到pop 和push指令時觀察值和記憶體位置。

![](https://github.com/JIMWU0808/ESEmbedded_HW02/blob/master/img/2-7.png)
可以發現pop和push 會改變記憶體位置+4 和-4
![](https://github.com/JIMWU0808/ESEmbedded_HW02/blob/master/img/2-11.png)
可以發現push後記憶體的值和pop後記憶體的值

#3 結果與討論
使用push的時候記憶體位置會-4，一次打三個暫存器的話`push {r1,r2,r3}` 則會一次-12。記憶體中儲存的值則是按照順序 r1，r2，r3;
使用pop的時候記憶體位置會+4,一次打三個暫存器的話`pop {r1,r2,r3}` 則會一次+12。記憶體中儲存的值也是按照順序 r1，r2，r3;

這次有一個失敗的地方，就是打`push {r3,r1,r2}或是pop{r3,r1,r2}` compile會產生失敗 register range not in acending order, 目前我沒有辦法解決只好把指令拆開來打。
 

[ARM infomation center]: http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0489e/Cihfddaf.html

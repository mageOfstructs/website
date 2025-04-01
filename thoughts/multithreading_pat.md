# Multithreading

- Teach multithreading by explaining it with headpats

So imagine you're petting a dragon (foxxo, dog, cat, wolf, etc.) and another floof comes along and also wants to pet.
You both could try petting at the same time, but that may overwhelm the poor critter. (**race condition**)
Instead you two take turns petting the cutie. How do you determine which turn it is? Perhaps you agree that whoever is holding a certain object, like a colar or a bone, is allowed to pet the critter. (**lock**)
But waiting for your turn is boring, so you'd rather eep until it's your turn again. How would you (while eeping) know when it's your turn? You'll need something to wake you up, maybe the critter yipping when the other being's done. (**non-spinlock**)
Let's imagine a more complex situation by raising the "petting" limit of our hypothetical critter. A simple lock wouldn't suffice now and we're back where we started. Luckily, a certain scientist with a famous dislike of goto has found a cure to this very common problem, the **semaphore**. Think of that as a floof, that voluntarily counts the current number of beings petting. If that number reaches some threshold, they'll just disallow more beings joining in until other beings stop petting.

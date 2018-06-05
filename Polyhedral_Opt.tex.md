# Polyhedral Optimization

## High-Level Idea

The idea of **Polyhedral Optimization** is to first convert statement instances into points in vector space, which are rescheduled before converting back to statement instances. **Polyhedral Optimization** consists of the following steps:

- **Iteration Domains** where statement instances are converted to points in multidimensional space.
  - E.g., The Iteration Domain of the following code is given by $\mathscr{I}_S=\{S(i, j)|0 \leq i < n \cap 0 \leq j < i\}$
  
  The **Iteration Domain** usually forms a convex polygon, and hence the name **Polyhedral Optimization**.

```C++
for (unsigned i = 0; i < n; ++i)
	for (unsigned j = 0; j < i; ++j)
		S(i, j); // some statement instance
```

- **Scheduling** where points are rescheduled to perform optimizations.
  - E.g., 
    
    $\mathit{\Theta}_S={S(i, j)\rightarrow (i, j)}$ preserves the original execution order.
    
    $\mathit{\Theta}_S={S(i, j)\rightarrow (j, i)}$ performs *loop interchange*.

    $\mathit{\Theta}_S={S(i, j)\rightarrow (
      \lfloor \frac{i}{4}\rfloor, 
      \lfloor \frac{j}{4}\rfloor, 
      i \mod 4, j \mod 4)}$ performs *loop tiling (blocking)*.

- **Code Generation** where points in multidimensional space are converted back to statement instances, using **Iteration Domains** and **Schedules**.

## References

- [**LLVM Polly**](http://perso.ens-lyon.fr/christophe.alias/impact2011/impact-07.pdf) with [tutorial slides](https://llvm.org/devmtg/2016-03/Tutorials/applied-polyhedral-compilation.pdf).
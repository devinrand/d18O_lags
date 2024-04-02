Package to calculate benthic d18O lags using methodology published in Rand et al., (2024). This package can be used to calculate lags between: 
  1. radiocarbon and benthic d18O age models
  2. radiocarbon and synthetic d18O age models (Gebbie, 2012)
  3. benthic d18O stacks (using a Bayesian inversion).

Included are the BIGMACS (Lee & Rand et al., 2023) input/output age model and stack files for the: 
  1. Brazil Margin (Rand et al., 2024)
  2. Atlantic compilation (Rand, 2024)
  3. Iberian Margin vs Equatorial Pacific (Rand, 2024)

To reproduce results from Rand et al., (2024) or Rand, (2024) enter the number 1-8 on line 20 of main.m. The corresponding run is indicated in the comments on line 10-17. 

Description of functions saved in the scripts folder:
  1. NaN_check: removes time-slices if the percentage of MCMC samples that require extrapolation are greater than the specified critical value.
  2. Analytical: Applies Bayesian inversion to calculate lag between two stacks drawn with a Gaussian process regression (described in Rand, 2024).
  3. calc_lag_diff: finds difference between 2 lag stacks
  4. calc_lag_stack: calculates average of multiple lag time-series
  5. calculate_lag: finds the age difference between radiocarbon and d18O age models by interpolating and subtracting MCMC samples.
  6. calculate_lag_gebbie: calculates time difference between the aligned synthetic d18O and model time.

Citations:

Rand, D., L. E. Lisiecki, T. Lee, C. W. Lawrence, and G. Gebbie. "Quantifying benthic δ18O lags across Termination 1: A probabilistic approach based on radiocarbon and benthic δ18O chronologies." Geochemistry, Geophysics, Geosystems 25, no. 2 (2024): e2023GC011068.

Lee, Taehee, Devin Rand, Lorraine E. Lisiecki, Geoffrey Gebbie, and Charles Lawrence. "Bayesian age models and stacks: combining age inferences from radiocarbon and benthic δ 18 O stratigraphic alignment." Climate of the Past 19, no. 10 (2023): 1993-2012.

Rand, Devin Scott. "Ocean Sediment Core Age Models, Stacks, and Benthic Foraminiferal δ18O Lags." PhD diss., UC Santa Barbara, 2023.

Gebbie, Geoffrey. "Tracer transport timescales and the observed Atlantic‐Pacific lag in the timing of the Last Termination." Paleoceanography 27, no. 3 (2012).
Harvard	


# Epidemic Modelling using SIR Models

## Summary

Throughout this project, we have seen the modelling and simulation of an epidemic. We used a SIR Model, a kind of epidemiology model which represents three categories of people:

-   *S*: People who are "susceptible", that is, capable of
    contracting the disease if they come into contact with someone who
    is infected.

-   *I*: People who are "infectious", that is, capable of passing
    along the disease if they come into contact with someone
    susceptible.

-   *R*: People who are "recovered". In the basic version of the
    model, people who have recovered are considered to be immune to
    reinfection. This can also include patients who have died due to infection as they cannot get the infection again anymore. 



We defined the parameters of `beta` and `gamma` as contact rate and recovery rate rescpectively, and the equations that would be used to define the change in each category of the model with rescpect to time. 


We started off with a base model, with fixed values of `beta` and `gamma` to show the relationship of those values with the proportion of infected people in a fixed and closed population. 

We then went a step farther, and viewed that relationship with sweeping values of the parameters to represent the uncertainty when deciding a value for `beta` and `gamma` and how they can affect the results if chosen inappropriately. 


Finally, we introduced a fourth category of people into the mix: *V* - People who are vaccinated, and a new parameter `alpha` which is the vaccination rate. We redefined the equations for the model, and used a fixed `alpha` value to show the effectiveness of vaccination to control an epidemic. 

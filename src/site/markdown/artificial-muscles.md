# Artificial muscles

## Information

**Artificial muscles** are actuators that mimic the contraction and expansion behaviour of biological muscle tissue.
They produce mechanical force or displacement in response to an external stimulus such as electrical voltage, air
pressure, heat, or chemical change.

### Types

**Pneumatic Artificial Muscles (PAMs) / McKibben actuators**

A braided rubber tube that contracts axially when pressurised. When inflated with compressed air (or fluid), the
braided mesh causes radial expansion and axial shortening, generating pulling force. Simple to build, high force
density, inherently compliant.

**Dielectric Elastomer Actuators (DEAs)**

A soft capacitor: two flexible electrodes sandwich a thin elastomer film. Applying high voltage (kilovolts) attracts
the electrodes, compresses the film thickness, and causes area expansion. Very high energy density, silent, but
requires high voltage electronics.

**Shape Memory Alloys (SMAs)**

Metal alloys (typically Nickel-Titanium / Nitinol) that return to a pre-set shape when heated above a transition
temperature. Can generate large forces in small packages but are slow to cycle due to thermal heating/cooling limits
and have limited fatigue life.

**Hydrogel actuators**

Polymer networks that swell or shrink in response to water content, pH, temperature, or light. Used in biomedical and
micro-scale applications. Slow actuation but bio-compatible.

**Twisted and coiled polymer (TCP) actuators**

Fishing line or nylon thread twisted and coiled to create a spring-like structure. Contracts when heated. Very low
cost, lightweight, moderate force and stroke.

### Applications

* Soft robotics — grippers, locomotion, manipulation in unstructured environments.
* Prosthetics and exoskeletons — lightweight actuators for assistive devices.
* Haptics — tactile feedback in wearables and VR controllers.
* Biomedical devices — surgical tools, implantable micro-actuators.
* Aerospace — lightweight morphing structures.

## Usage, tips and tricks

### Design trade-offs

| Type   | Force | Stroke | Speed | Power  | Complexity | Cost  |
|--------|-------|--------|-------|--------|------------|-------|
| PAM    | High  | Medium | Fast  | Pneumatic | Low     | Low   |
| DEA    | Medium| Large  | Fast  | Electric (HV) | High | Medium |
| SMA    | High  | Small  | Slow  | Thermal | Low       | Low   |
| TCP    | Low   | Medium | Slow  | Thermal | Low       | Very low |
| Hydrogel| Low  | Large  | Slow  | Chemical/thermal | Low | Low |

* For compliant manipulation tasks, PAMs offer the best balance of force, compliance, and simplicity.
* DEAs require high-voltage amplifiers (1–10 kV); this limits practical deployment outside research labs.
* SMAs are best for one-way shape change or low-cycle applications; fatigue is a limiting factor in repetitive use.
* TCP actuators suit low-budget wearable or educational robotics where speed is not critical.

## See also

* [Artificial muscle in Wikipedia](https://en.wikipedia.org/wiki/Artificial_muscle)
* [Pneumatic artificial muscles in Wikipedia](https://en.wikipedia.org/wiki/Pneumatic_artificial_muscles)
* [Robotica](robotica.md)
